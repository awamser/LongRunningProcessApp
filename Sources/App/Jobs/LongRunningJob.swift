import Queues
import Vapor

struct LongRunningJob: AsyncJob {
  struct Payload: Codable {
    let clientID: UUID
  }

  func dequeue(_ context: QueueContext, _ payload: Payload) async throws {
    try await Task.sleep(nanoseconds: 5 * 1_000_000_000)  // 5 seconds

    context.application.eventLoopGroup.next().execute {
      // context.application.client.send(request: ClientRequest)
    }
  }

  func error(_ context: QueueContext, _ error: Error, _ payload: Payload) async {
    context.application.logger.error("Error processing job: \(error)")
  }
}
