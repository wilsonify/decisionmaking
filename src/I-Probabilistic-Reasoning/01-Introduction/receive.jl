using Formatting
using AMQPClient
const HOST = "localhost"
const PORT = "5762"
const VIRTUALHOST = "/"
const ROUTING_KEY = "julia"

function receive()
    connection(; virtualhost = VIRTUALHOST, host = HOST, port = parse(Int64, PORT)) do conn
        channel(conn, AMQPClient.UNUSED_CHANNEL, true) do chan
            exchange_name = format("try_{:s}", ROUTING_KEY)
            queue_name = format("try_{:s}", ROUTING_KEY)
            binding_key = format("try_{:s}", ROUTING_KEY)
            exchange_declare(chan, exchange_name, EXCHANGE_TYPE_TOPIC)
            result, queue_name, message_count, consumer_count = queue_declare(chan, queue_name, exclusive = true)
            queue_bind(chan, queue_name, exchange_name, binding_key)

            println(" [*] Waiting for messages. To exit press CTRL+C")

            on_receive = (msg) -> begin
                data = String(msg.data)
                println("Received the message: $data")
                basic_ack(chan, msg.delivery_tag)
            end

            success, consumer_tag = basic_consume(chan, queue_name, on_receive)

            while true
                sleep(1)
            end
        end
    end
end





