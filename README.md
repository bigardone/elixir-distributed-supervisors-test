# Distributed supervisors test

#### Version by [princemaple](https://github.com/princemaple)

## Background
We need a worker which performs a task periodically.

## What we want
If we distribute the application in multiple nodes, we want the worker process to be running just once.
If the process dies, we want the current node to start it again.
If the node running the process dies, we want a different node to take care of restarting the worker again.

## Solution
If the `DistributedTest.Server` process already exists while trying to start it by any of the nodes,
it will link its **PID**. Therefore, if the node running the worker happens to die, the other nodes
will be automatically notified and will try to restart it again.

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
