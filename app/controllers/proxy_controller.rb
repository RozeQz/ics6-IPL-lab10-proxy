# frozen_string_literal: true

require 'nokogiri'
require 'http'

# Контроллер запросов к api-приложению.
class ProxyController < ApplicationController
  # Эти методы вызываются перед вызовом метода view.
  before_action :parse_params, only: :view
  before_action :prepare_url, only: :view

  def input; end

  # Отсылает запрос другому приложению в зависимости от желания клиента.
  def view
    # Делаем запрос и получаем ответ от другого сервера в виде XML-документа
    api_response = HTTP.get(@url).body

    # Если делать XML -> HTML на сервере.
    case @side
    when 'server'
      @result = xslt_transform(api_response).to_html
      render 'view'
    # Если делать XML -> HTML на браузере.
    when 'client-with-xslt'
      render xml: insert_browser_xslt(api_response).to_xml
    # Если сырой XML.
    else
      render xml: api_response
    end
  end

  private

  # Куда шлем запрос.
  BASE_API_URL           = 'http://localhost:3001/xml/view.xml?'
  # Откуда браузер должен брать XSLT. Это подставится к localhost:3001. Так грузятся файлы из public.
  XSLT_BROWSER_TRANSFORM = '/browser_transform.xslt'
  # Откуда берем XSLT для преобразования на стороне сервера.
  XSLT_SERVER_TRANSFORM  = "#{Rails.root}/public/server_transform.xslt".freeze

  def parse_params
    @input_number = params[:n]
    @side = params[:side]
  end

  def prepare_url
    @url = BASE_API_URL + "n=#{@input_number}"
  end

  # Преобразование XSLT на сервере.
  def xslt_transform(data, transform: XSLT_SERVER_TRANSFORM)
    doc = Nokogiri::XML(data)
    xslt = Nokogiri::XSLT(File.read(transform))
    xslt.transform(doc)
  end

  # Чтобы преобразование XSLT на клиенте работало, надо вставить ссылку на XSLT.
  def insert_browser_xslt(data, transform: XSLT_BROWSER_TRANSFORM)
    doc = Nokogiri::XML(data)
    xslt = Nokogiri::XML::ProcessingInstruction.new(doc, 'xml-stylesheet', "type=\"text/xsl\" href=\"#{transform}\"")
    doc.root.add_previous_sibling(xslt)
    doc
  end
end
