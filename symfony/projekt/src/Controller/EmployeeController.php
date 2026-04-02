<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\HttpFoundation\Request;
use App\Entity\Employee;
use App\Repository\EmployeeRepository;
use Doctrine\ORM\EntityManagerInterface;

#[Route('/api/employees')]
final class EmployeeController extends AbstractController
{
    #[Route('', methods: ['GET'])]
    public function index(EmployeeRepository $repo): JsonResponse
    {
        return $this->json($repo->findAll());
    }

    #[Route('', methods: ['POST'])]
    public function create(Request $request, EntityManagerInterface $em): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        $emp = new Employee();
        $emp->setName($data['name'] ?? 'Brak imienia');
        $emp->setPosition($data['position'] ?? 'Brak stanowiska');
        
        $em->persist($emp);
        $em->flush();
        return $this->json($emp, 201);
    }

    #[Route('/{id}', methods: ['GET'])]
    public function show(Employee $emp): JsonResponse
    {
        return $this->json($emp);
    }

    #[Route('/{id}', methods: ['PUT'])]
    public function update(Request $request, Employee $emp, EntityManagerInterface $em): JsonResponse
    {
        $data = json_decode($request->getContent(), true);
        if (isset($data['name'])) $emp->setName($data['name']);
        if (isset($data['position'])) $emp->setPosition($data['position']);
        
        $em->flush();
        return $this->json($emp);
    }

    #[Route('/{id}', methods: ['DELETE'])]
    public function delete(Employee $emp, EntityManagerInterface $em): JsonResponse
    {
        $em->remove($emp);
        $em->flush();
        return $this->json(null, 204);
    }

    #[Route('/view/html', methods: ['GET'])]
    public function viewHtml(EmployeeRepository $repo): \Symfony\Component\HttpFoundation\Response
    {
        return $this->render('employee.html.twig', [
            'employees' => $repo->findAll()
        ]);
    }
}
