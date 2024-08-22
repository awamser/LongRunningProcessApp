import Leaf
import QueuesRedisDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
  app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

  app.views.use(.leaf)
  try await tailwind(app)

  // Redis
  try app.queues.use(
    .redis(
      .init(
        url: "redis://127.0.0.1:6379",
        pool: .init(connectionRetryTimeout: .seconds(2)))))

  // register routes
  try routes(app)
}
