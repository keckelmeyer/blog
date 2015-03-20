class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "keckelmeyer", password: "Sigm@666", except: [:index, :show]



  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
=begin
A couple of things to note. We use Article.find to
find the article we're interested in, passing in
params[:id] to get the :id parameter from the request.
We also use an instance variable (prefixed with @) to
hold a reference to the article object. We do this
because Rails will pass all instance variables to the
view.

Now, create a new file app/views/articles/show.html.erb
=end
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
=begin
We have to whitelist our controller parameters to
prevent wrongful mass assignment. In this case,
we want to both allow and require the title and
text parameters for valid use of create. The syntax
for this introduces require and permit.

This is often factored out into its own method so it
can be reused by multiple actions in the same controller,
for example create and update. Above and beyond mass
assignment issues, the method is often made private to
make sure it can't be called outside its intended
context. (see private below)

Then we create a model that will take our create
action and use it to put data into the database.

rake db:migrate will create the database, based
on the model just created.
=end
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
=begin
Here's what's going on: every Rails model can be
initialized with its respective attributes, which
are automatically mapped to the respective database
columns. In the first line we do just that
(remember that params[:article] contains the
attributes we're interested in). Then, @article.save
is responsible for saving the model in the database.
Finally, we redirect the user to the show action,
which we'll define later.

With the validation now in place, when you call
@article.save on an invalid article, it will return
false. If you open app/controllers/articles_controller.rb
again, you'll notice that we don't check the result of
calling @article.save inside the create action. If
@article.save fails in this situation, we need to show
the form back to the user.
=end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :text)
  end

end
