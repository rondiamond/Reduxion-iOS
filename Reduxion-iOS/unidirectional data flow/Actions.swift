import Foundation

/**
 Used to specify the type of command being issued to the various Logic modules, via LogicController.sharedInstance.performAction(...).

 NOTE: Actions are executed on the Main thread, via one or more Logic modules.
 Any expensive action logic should be performed asynchronously (on a background thread), and a separate 'store results' action performed, which would in turn mutate the appState itself on the main thread.
 */
enum Action {
    case null

    case action1(argument: Bool)
}
