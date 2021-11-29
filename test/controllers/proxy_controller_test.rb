# frozen_string_literal: true

require 'test_helper'

class ProxyControllerTest < ActionDispatch::IntegrationTest
  test 'should get input in html by default' do
    get proxy_input_url
    assert_response :success
    assert_equal 'text/html', @response.media_type
  end

  test 'should get view in xml' do
    get "#{proxy_view_url}.xml"
    assert_response :success
    assert_equal 'application/xml', @response.media_type
  end

  test 'should get different response for different requests' do
    get "#{proxy_view_url}.xml?n=10"
    response_one = @response.body.clone

    get "#{proxy_view_url}.xml?n=100"
    response_two = @response.body.clone

    assert_not_equal response_one, response_two
  end

  test 'should get empty input error' do
    get "#{proxy_view_url}?n="
    response = @response.body.clone

    assert_includes response, '<error>Пустой ввод. Вы ничего не ввели!</error>'
  end

  test 'should get incorrect input error' do
    get "#{proxy_view_url}?n=zxc"
    response = @response.body.clone

    assert_includes response, '<error>Некорректный ввод. Используйте только цифры!</error>'
  end
end
