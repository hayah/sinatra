require './models/caesars_cipher'


get '/' do
  cipher = CaesarsCipher.new('Hello, Umpjb!', 2)
  message = cipher.translate
  erb :index, locals: { cipher: cipher, message: message}
end

post '/' do
  cipher = CaesarsCipher.new(params[:string], params[:step].to_i)
  message = cipher.translate
  erb :index, locals: { cipher: cipher, message: message }
end
