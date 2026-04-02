<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\HttpFoundation\Request;
use App\Entity\Supplier;
use App\Repository\SupplierRepository;
use Doctrine\ORM\EntityManagerInterface;

#[Route('/api/suppliers')]
final class SupplierController extends AbstractController
{
    #[Route('', methods: ['GET'])]
    public function index(SupplierRepository $repo): JsonResponse
    {
        return $this->json($repo->findAll());
    }

    #[Route('', methods: ['POST'])]
    public function create(Request $request, EntityManagerInterface $em): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $sup = new Supplier();
        $sup->setCompany($data['company'] ?? 'Brak nazwy');
        $sup->setPhone($data['phone'] ?? 'Brak telefonu');
        
        $em->persist($sup);
        $em->flush();
        return $this->json($sup, 201);
    }

    #[Route('/{id}', methods: ['GET'])]
    public function show(Supplier $sup): JsonResponse
    {
        return $this->json($sup);
    }

    #[Route('/{id}', methods: ['PUT'])]
    public function update(Request $request, Supplier $sup, EntityManagerInterface $em): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        if (isset($data['company'])) $sup->setCompany($data['company']);
        if (isset($data['phone'])) $sup->setPhone($data['phone']);
        
        $em->flush();
        return $this->json($sup);
    }

    #[Route('/{id}', methods: ['DELETE'])]
    public function delete(Supplier $sup, EntityManagerInterface $em): JsonResponse
    {
        $em->remove($sup);
        $em->flush();
        return $this->json(null, 204);
    }

    #[Route('/view/html', methods: ['GET'])]
    public function viewHtml(SupplierRepository $repo): \Symfony\Component\HttpFoundation\Response
    {
        return $this->render('supplier.html.twig', [
            'suppliers' => $repo->findAll()
        ]);
    }
}