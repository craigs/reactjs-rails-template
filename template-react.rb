gem 'haml-rails'
gem 'react-rails', '~> 1.0.0.pre', github: 'reactjs/react-rails'
gem 'flux-rails-assets'
gem 'sprockets-coffee-react'

run "mkdir app/assets/javascripts/components"
run "mkdir app/assets/javascripts/stores"
run "rm app/assets/javascripts/application.js"

file 'app/assets/javascripts/application.js.coffee', <<-CODE
#= require jquery
#= require jquery_ujs
#= require react
#= require react_ujs
#= require components
#= require flux
#= require eventemitter
#= require dispatcher
#= require_tree .
CODE

file 'app/assets/javascripts/components.js.coffee', <<-CODE
#= require_tree ./components
CODE

file 'app/assets/javascripts/dispatcher.js.coffee', <<-CODE
window.AppDispatcher = new FluxDispatcher()
CODE

run "rm app/views/layouts/application.html.erb"

file 'app/views/layouts/application.html.haml', <<-CODE
!!! 5
%html

  %head
    %title Sample React.js with Rails Application
    = stylesheet_link_tag 'application', media: 'all'
    = javascript_include_tag 'application'
    = csrf_meta_tags

  %body

    = yield
CODE

file 'app/assets/javascripts/components/button.js.cjsx', <<-CODE
@Button = React.createClass

  onClick: ->
    alert "You clicked on Button.onClick"

  render: ->
    <button onClick={ this.onClick }>{ this.props.text }</button>
CODE

file 'app/views/welcome/index.html.haml', <<-CODE
= react_component "Button", { text: "Sample Button" }, { prerender: true }
CODE

file 'app/controllers/welcome_controller.rb', <<-CODE
class WelcomeController < ApplicationController
  def index
  end
end
CODE

route "root to: 'welcome#index'"
