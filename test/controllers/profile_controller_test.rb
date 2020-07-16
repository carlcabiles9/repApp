# frozen_string_literal: true

require 'test_helper'

class ProfileControllerTest < ActionDispatch::IntegrationTest
  test 'should get user:references' do
    get profile_user: references_url
    assert_response :success
  end

  test 'should get firstname:text' do
    get profile_firstname: text_url
    assert_response :success
  end

  test 'should get lastname:text' do
    get profile_lastname: text_url
    assert_response :success
  end

  test 'should get number:text' do
    get profile_number: text_url
    assert_response :success
  end

  test 'should get street:text' do
    get profile_street: text_url
    assert_response :success
  end

  test 'should get bldg:text' do
    get profile_bldg: text_url
    assert_response :success
  end

  test 'should get city:text' do
    get profile_city: text_url
    assert_response :success
  end

  test 'should get province:text' do
    get profile_province: text_url
    assert_response :success
  end

  test 'should get status:text' do
    get profile_status: text_url
    assert_response :success
  end
end
