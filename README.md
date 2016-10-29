# Distributed supervisors test

## Background
We need a worker which performs a task periodically.

## What we want
If we distribute the application in multiple nodes, we want the worker process to be running just once.
If the process dies, we want the current node to start it again.
If the node running the process dies, we want a different node to take care of restarting the worker again.

# Alternative solutions
- https://github.com/bigardone/elixir-distributed-supervisors-test/tree/princemaple-version by [princemaple](https://github.com/princemaple)

## Original solution
We have 3 different components:

- The `DistributedTest.Server` worker, which is registered globally.
- The `DistributedTest.ServerSupervisor` which tries to start the previous worker.
- The `DistributedTest.NodeMonitor` which checks for nodes dying.


The application starts the three of them.
When the `DistributedTest.Server` gets started, it will return the new pid or the existing one, if it was started on a different node, and it will begin doing its periodical task.
The `DistributedTest.NodeMonitor`, monitors the existing nodes, and in case one dies, it tries to start a new `DistributedTest.Server` process using the `DistributedTest.ServerSupervisor`.

## Test
Open three different terminal windows and start one different node in each of them:

```
$ iex --name n1@127.0.0.1 --erl "-config sys.config" -S mix
$ iex --name n2@127.0.0.1 --erl "-config sys.config" -S mix
$ iex --name n3@127.0.0.1 --erl "-config sys.config" -S mix
```

Try to kill the `DistributedTest.Server` process and watch it restart again. Finish the node session where it is currently running, and watch how any of the other nodes starts the process again.

Feedback and suggestions are welcomed :)


![http://g.recordit.co/rbxRoxoHXc.gif](http://g.recordit.co/rbxRoxoHXc.gif)
