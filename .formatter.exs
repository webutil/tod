[
  inputs: [
    "*.exs",
    "config/*.exs",
    "lib/**/*.ex",
    "priv/**/*.exs",
    "scripts/*.exs",
    "test/**/*.{ex,exs}"
  ],
  import_deps: [],
  locals_without_parens: [
    delete: 3,
    forward: 2,
    get: 3,
    pipe_through: 1,
    patch: 3,
    plug: 1,
    plug: 2,
    post: 3,
    put: 3,
    socket: 2,
    resources: 2,
    resources: 3
  ]
]
