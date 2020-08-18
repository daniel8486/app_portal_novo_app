class Pages::PointController < PagesController

 def index  
  if params[:commit].to_s == "Enviar"
    #puts "enviando valores"
     enviarDados(params[:data_ini],params[:data_fim]) 
      request[:data_ini] = params[:data_ini]
      request[:data_fim] = params[:data_fim]
    else
     puts "ERROU!" 
    end
 
 end 

def enviarDados(data_ini,data_fim)
 
  client = Savon.client(
  :wsdl => 'http://10.1.11.161/TOTVSBusinessConnect/wsConsultaSQL.asmx?wsdl',
  :log => true,
  :pretty_print_xml => true,
  basic_auth:["4456","040113"],
  ssl_verify_mode: :none,
  log_level: :debug, 
)
message = {
  #"codSentenca" => 'BATIDASS',
  #"codColigada" => '0',
  #"codAplicacao" => 'Y',
  #"Usuario" =>'mestre',
  #"Senha" => '@Pintos2019',
  #"parameters" => 'COD_PESSOA=4062;DATA_INI=2019-03-01 00:00:00;DATA_FIM=2019-03-10 00:00:00;',
  
  "codSentenca" => 'NEWPORTAL01_03',
  "codColigada" => '1',
  "codAplicacao" => 'P',
  "Usuario" => session[:username],
  "Senha" => session[:password],
  'parameters' => "'COD_PESSOA="+session[:username]+";DATA_INI="+request[:data_ini]+";DATA_FIM="+request[:data_fim]+";",
}

response = client.call(
    :realizar_consulta_sql_auth,
    message: message,
)

result = response.body[:realizar_consulta_sql_auth_response][:realizar_consulta_sql_auth_result]


doc = Nokogiri::Slop(result)


@result = doc.NewDataSet.Resultado


rescue Exception => e 
 

e.message


end

end 
