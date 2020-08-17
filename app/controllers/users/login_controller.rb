class Users::LoginController < UsersController 
  def index 
    
    if params[:commit].to_s == "Acessar"
      puts "chamar autenticacao"
      if authenticationRM(params[:username].to_s,params[:password]) == "1"
        # puts "Tudo certo chamar login"
        # @username = login("USUARIO"+params[:username].to_s)
        # puts @username

        session[:username] = params[:username]
        session[:password] = params[:password]

        redirect_to '/v1/wsdl/inicio'
      else
        flash[:alert] = "Usuário ou Senha Invalida."
      end
    end
  

end


def authenticationRM(username,password) 
  
  @client = Savon.client(
    :wsdl => 'http://10.1.11.161/TOTVSBusinessConnect/wsDataServer.asmx?wsdl',
    # env_namespace: :soapenv,
    # element_form_default: :qualified,
    :log => true,
    :pretty_print_xml => true,
    basic_auth:["4456","040113"],
    ssl_verify_mode: :none,
    log_level: :debug, 
  )

  message = {
    "Usuario" => username.to_s,
    "Senha" => password,
  }  

  response = @client.call(
    :autentica_acesso_auth,
    message: message,
  )

  result = response.body[:autentica_acesso_auth_response][:autentica_acesso_auth_result]

  rescue Exception => e
    e.message

end
end
