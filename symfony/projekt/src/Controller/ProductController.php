<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\HttpFoundation\Request;
use App\Entity\Product;
use App\Repository\ProductRepository;
use Doctrine\ORM\EntityManagerInterface;

#[Route('/api/products')]

final class ProductController extends AbstractController
{
    #[Route('', methods: ['GET'])]
    public function index(ProductRepository $productRepository): JsonResponse
    {
        $products = $productRepository->findAll();
        return $this->json($products);
    }

    #[Route('', methods: ['POST'])]
    public function create(Request $request, EntityManagerInterface $entityManager): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        $product = new Product();
        $product->setName($data['name'] ?? 'Nieznany produkt');
        $product->setPrice($data['price'] ?? 0.0);
        $product->setCategory($data['category'] ?? 'Brak kategorii');

        $entityManager->persist($product);
        $entityManager->flush();

        return $this->json($product, 201);
    }

    #[Route('/{id}', methods: ['GET'])]
    public function show(Product $product): JsonResponse
    {
        return $this->json($product);
    }

    #[Route('/{id}', methods: ['PUT'])]
    public function update(Request $request, Product $product, EntityManagerInterface $entityManager): JsonResponse
    {
        $data = json_decode($request->getContent(), true);

        if (isset($data['name'])) {
            $product->setName($data['name']);
        }
        if (isset($data['price'])) {
            $product->setPrice($data['price']);
        }
        if (isset($data['category'])) {
            $product->setCategory($data['category']);
        }

        $entityManager->flush();

        return $this->json($product);
    }

    #[Route('/{id}', methods: ['DELETE'])]
    public function delete(Product $product, EntityManagerInterface $entityManager): JsonResponse
    {
        $entityManager->remove($product);
        $entityManager->flush();

        return $this->json(null, 204);
    }

    #[Route('/view/html', methods: ['GET'])]
    public function viewHtml(ProductRepository $repo): \Symfony\Component\HttpFoundation\Response
    {
        return $this->render('product.html.twig', [
            'products' => $repo->findAll()
        ]);
    }
}
