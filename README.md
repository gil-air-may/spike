# Spike

Spike is a minimalist WebSockets server built with Elixir, designed to demonstrate essential concepts like Plug and OTP without the overhead of a full framework. Instead of using the typical Cowboy Erlang server, Spike utilizes the modern, pure Elixir server called Bandit.

## Getting Started

### Prerequisites

- Elixir 1.12+
- Erlang/OTP 24+

### Installation

Clone the repository:

```bash
git clone https://github.com/gil-air-may/spike.git
cd spike
```

Install dependencies:

```bash
mix deps.get
```

### Running the Server

To start the WebSockets server:

```bash
mix run --no-halt
```

### Usage

Open a WebSockets client and connect to:

```
ws://localhost:4000/[id]
```

You can replace the [id] parameter with any number which will be assigned to your client.
If you want to test without having to configure the frontend, I recommend downloading Postman and using it as a websocket client.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.
---