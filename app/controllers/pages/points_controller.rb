class Pages::PointsController < PagesController
  def index

    @client = Savon.client(
    :wsdl => 'http://10.1.11.161/TOTVSBusinessConnect/wsDataServer.asmx?wsdl',
    :log => false,
    :pretty_print_xml => false,
    basic_auth:["4456","040113"],
    ssl_verify_mode: :none,
    log_level: :debug, 
    )
    message = {
    'DataServerName' => 'PTODATAJUSTIFICATIVAEXCECOES' ,
    'Filtro' => 'CODPESSOA='+session[:username]+'',
    'Contexto' => 'CODCOLIGADA=1;CODSISTEMA=G;CODUSUARIO=mestre;',
    'Usuario' => '4456',
    'Senha' => '040113',
    }  
  
    response = @client.call(
    :read_view_auth,
    message: message,
    )
  
    result = response.body[:read_view_auth_response][:read_view_auth_result]
  
    doc = Nokogiri::Slop(result)
    
    @result = doc.NewDataSet.AJUSTFUN 

    read(result)   
     
    rescue Exception => e 
     
    e.message

    if params[:commit].to_s == "Enviar"
      #  pegaDados(params[:justificativa],params[:linha]) 
      #  request[:justificativa] = params[:justificativa]
      #  request[:linha] = params[:linha]

      # puts "======================"
      # puts @result[params[:linha].to_i].CODCOLIGADA.content
      # puts @result[params[:linha].to_i].CHAPA.content
      # puts @result[params[:linha].to_i].DATA.content
      # puts @result[params[:linha].to_i].INICIO.content
      # puts @result[params[:linha].to_i].TIPOOCORRENCIA.content
      
      read_record(@result[params[:linha].to_i].CODCOLIGADA.content, 
      @result[params[:linha].to_i].CHAPA.content,
      @result[params[:linha].to_i].DATA.content,
      @result[params[:linha].to_i].INICIO.content,
      @result[params[:linha].to_i].TIPOOCORRENCIA.content)

    else
      #puts "ERROU!" 
    end
      
  end 

  def read_record(cod_coligada,chapa,data,inicio,tipo_ocorrencia)

    client = Savon.client(
    :wsdl => 'http://10.1.11.161/TOTVSBusinessConnect/wsDataServer.asmx?wsdl',
    env_namespace: :soapenv,
    element_form_default: :qualified,
    :log => true,
    :pretty_print_xml => true,
    basic_auth:["4456","040113"],
    ssl_verify_mode: :none,
    log_level: :debug, 
  )
    
  message = {
    'DataServerName' => 'PTODATAJUSTIFICATIVAEXCECOES' ,
    'PrimaryKey' => 
      "#{@result[params[:linha].to_i].CODCOLIGADA.content};#{@result[params[:linha].to_i].CHAPA.content};#{@result[params[:linha].to_i].DATA.content};#{@result[params[:linha].to_i].INICIO.content};#{@result[params[:linha].to_i].TIPOOCORRENCIA.content}",
    'Contexto' => 'CODCOLIGADA=1;',
  }  

  response = client.call(
    :read_record,
    message: message,
  )
    
  result = response.body[:read_record_response][:read_record_result]

  doc = Nokogiri::Slop(result_one)

  @result = doc.PtoJustFunOcorrencias.AJUSTFUN 

  save_record(result)   
     
  rescue Exception => e 
     
  e.message

  save_record(@result[params[:linha].to_i].CODCOLIGADA.content, 
      @result[params[:linha].to_i].CHAPA.content,
      @result[params[:linha].to_i].DATA.content,
      @result[params[:linha].to_i].INICIO.content,
      @result[params[:linha].to_i].FIM.content,
      @result[params[:linha].to_i].NUMHORASSTR.content,
      @result[params[:linha].to_i].INICIOSTR.content,
      @result[params[:linha].to_i].FIMSTR.content,
      @result[params[:linha].to_i].TIPOOCORRENCIA.content,
      @result[params[:justificativa].to_i].JUSTIFICATIVA.content,
      @result[params[:linha].to_i].ATITUDE.content,
      @result[params[:linha].to_i].NUMHORASSTR.content)
      #@result[params[:linha].to_i].CAMPOCALCULADO.content,
      #@result[params[:lnha].to_i].ATITUDESTR.content)

  end
  
  def save_record(cod_coligada,chapa,data,inicio,fim,numhorasstr,iniciostr,fimstr,tipo_ocorrencia,justificativa,atitude,numhoras)


    @client = Savon.client(
      :wsdl => 'http://10.1.11.161/TOTVSBusinessConnect/wsDataServer.asmx?wsdl',
      #:endpoint => 'http://www.totvs.com.br/br/',
      #:namespace => "xmlns:br=http://www.totvs.com.br/br/",
      headers: {
        "Authorization" => 'Basic NDQ1NjowNDAxMTM=', 
        "Connection" => 'Keep-Alive', 
        "Accept-Encoding" => "gzip,deflate", 
        "Content-Type" => "text/xml;charset=utf-8",
        "SOAPAction" => "http://www.totvs.com.br/br/SaveRecordAuth",
      },
      env_namespace: :soapenv,
      element_form_default: :qualified,
      :log => true,
      :pretty_print_xml => true,
      basic_auth:["4456","040113"],
      ssl_verify_mode: :none,
      log_level: :debug
    )
  
    message = {
      'DataServerName'=>'PTODATAJUSTIFICATIVAEXCECOES',
      'XML'=>"<AJUSTFUN>
               <CODCOLIGADA>#{@result[params[:linha].to_i].CODCOLIGADA.content}</CODCOLIGADA>
               <CHAPA>#{@result[params[:linha].to_i].CHAPA.content}</CHAPA>
               <DATA>#{@result[params[:linha].to_i].DATA.content}</DATA>
               <INICIO>#{@result[params[:linha].to_i].INICIO.content}</INICIO>
               <FIM>#{@result[params[:linha].to_i].FIM.content}</FIM>
               <NUMHORASSTR>#{@result[params[:linha].to_i].NUMHORASSTR.content}</NUMHORASSTR>
               <INICIOSTR>#{@result[params[:linha].to_i].INICIOSTR.content}</INICIOSTR>
               <FIMSTR>#{@result[params[:linha].to_i].FIMSTR.content}</FIMSTR>
               <TIPOOCORRENCIA>#{@result[params[:linha].to_i].TIPOOCORRENCIA.content}</TIPOOCORRENCIA>
               <JUSTIFICATIVA>#{params[:justificativa].to_s}</JUSTIFICATIVA>
               <ATITUDE>#{@result[params[:linha].to_i].ATITUDE.content}</ATITUDE>
               <NUMHORAS>#{@result[params[:linha].to_i].NUMHORAS.content}</NUMHORAS>
           </AJUSTFUN>",
      'Contexto' => 'CODSISTEMA=A;CODCOLIGADA=1;CODUSUARIO=4456',
      'Usuario' => '4456',
      'Senha' => '040113',
    }  
  
    response = @client.call(
      :save_record_auth,
      message: message,
    )
  
    result = response.body[:save_record_auth_response][:save_record_auth_result]
  
    puts result

    #@result = result

    flash[:notice] = "Ponto Salvo com Sucesso ... #{result}"

  end
end
