import Vapor
import Fluent
import FluentSQLiteDriver

public func configure(_ app: Application) async throws {
    // SQLite
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

    // Migracje
    app.migrations.add(CreateProduct())

    // Routes
    try routes(app)
}