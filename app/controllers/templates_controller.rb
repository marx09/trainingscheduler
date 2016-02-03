class TemplatesController < ApplicationController
  def index
    @templates = Template.all
    @template = Template.new
  end
  
  def save_template
  end
  
  def destroy
  end
  
end
