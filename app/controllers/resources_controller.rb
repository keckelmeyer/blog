class ResourcesController < ApplicationController

  http_basic_authenticate_with name: "keckelmeyer", password: "Sigm@666", except: [:index, :show]
#
  def index
    @resources=Resource.all

  end

  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      redirect_to @resource
    else
      render 'new'
    end
  end

  def new
    @resource = Resource.new
    @category_options = Category.all.map{|c| [c.name]}
    #@category_options = Category.all.map{|c| [c.name, c.id]}
  end

  def edit
    @resource = Resource.find(params[:id])
    @category_options = Category.all.map{|c| [c.name]}
  end

  def update
    @resource = Resource.find(params[:id])
    if @resource.update(resource_params)
      redirect_to @resource
    else
      render 'edit'
    end
  end

  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    redirect_to resource_path
  end

end

private
def resource_params
  params.require(:resource).permit(:category, :title, :link)
end

def shit
  params.require(:resource)
end