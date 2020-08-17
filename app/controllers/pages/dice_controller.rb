class Pages::DiceController < PagesController
  def index
    client = Savon.client(
    :wsdl => 'http://10.1.11.161/TOTVSBusinessConnect/wsConsultaSQL.asmx?wsdl',
    # env_namespace: :soapenv,
    # element_form_default: :qualified,
    :log => true,
    :pretty_print_xml => true,
    basic_auth:["4456","040113"],
    ssl_verify_mode: :none,
    log_level: :debug, 
  )

#   client.operations

  message = {
    "codSentenca" => 'NEWPORTAL01_01',
    "codColigada" => '0',
    "codAplicacao" => 'P',
    "Usuario" => session[:username],
    "Senha" => session[:password],
    'parameters' => "'COD_PESSOA="+session[:username]+";'"
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
