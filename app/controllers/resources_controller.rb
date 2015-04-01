class ResourcesController < ApplicationController

  http_basic_authenticate_with name: "PSERS", password: "2015", except: [:_index, :show]
#
  def _index
    @resources=Resource.order(:category, :title).all
    @resource_cat = @resources.group_by {|r| r.category}
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
    @category_options = Category.order(:name).all.map{|c| [c.name]}
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