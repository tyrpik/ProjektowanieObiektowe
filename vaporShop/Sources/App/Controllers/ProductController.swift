import Vapor
import Fluent

struct ProductController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let products = routes.grouped("products")

        products.get(use: index)
        products.post(use: create)
        products.put(":id", use: update)
        products.delete(":id", use: delete)
    }

    func index(req: Request) async throws -> [Product] {
        try await Product.query(on: req.db)
            .all()
    }

    func create(req: Request) async throws -> Product {
        let data = try req.content.decode(ProductForm.self)

        let product = Product(
            name: data.name,
            price: data.price,
            description: data.description
        )

        try await product.save(on: req.db)
        return product
    }

    func update(req: Request) async throws -> Product {
        guard let product = try await Product.find(
            req.parameters.get("id"),
            on: req.db
        ) else {
            throw Abort(.notFound)
        }

        let data = try req.content.decode(ProductForm.self)

        product.name = data.name
        product.price = data.price
        product.description = data.description

        try await product.save(on: req.db)
        return product
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let product = try await Product.find(
            req.parameters.get("id"),
            on: req.db
        ) else {
            throw Abort(.notFound)
        }

        try await product.delete(on: req.db)
        return .noContent
    }
}

struct ProductForm: Content {
    let name: String
    let price: Double
    let description: String
}