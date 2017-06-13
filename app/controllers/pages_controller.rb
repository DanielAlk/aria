class PagesController < ApplicationController
  include Cart
  include Filterize
  before_action :authenticate_user!, only: [:cart, :checkout, :confirm]
  before_action :set_cart, only: [:cart, :checkout]
  before_action :filterize, only: [:products, :tag, :works, :work_tag]
  filterize object: Proc.new { |p| [:works, :work_tag].include?(p[:action].to_sym) ? :work : :product }, order: :special_desc, scope: :active, param: :f
  layout 'soon', only: :soon
  
  def home
    @product_categories = Category.friendly.find('products').children
    @news = Article.limit(Article.shape_highlited(:news)).news.order(position: :asc)
  end

  def products_and_services
    @categories = Category.friendly.find('products').children
    @articles = Article.services.order(position: :asc)
  end

  def services_index
    @articles = Article.services.order(position: :asc)
  end

  def products
    if params[:category_id].present?
      @category = Category.friendly.find(params[:category_id])
      @products = @products.where(category: @category.subtree.map{|c| c})
      @products = @products.paginate(:page => params[:page], :per_page => params[:per_page] || 12)
    elsif params[:f].present?
      @products = @products.paginate(:page => params[:page], :per_page => params[:per_page] || 12)
    else
      @product_categories = Category.friendly.find('products').children
    end
  end

  def tag
    @tag = Tag.friendly.find(params[:tag_id])
    @products = @products.where(id: Tagging.where(taggable_type: 'Product', tag_id: @tag.id ).map(&:taggable_id))
    @products = @products.paginate(:page => params[:page], :per_page => params[:per_page] || 12)
    render :products
  end

  def product
    @product = Product.active.friendly.find(params[:product_id])
    @related_products = @product.category.products.active.where.not(id: @product.id).limit(10).shuffle
  end

  def works
    if params[:category_id].present?
      @category = Category.friendly.find(params[:category_id])
      @works = @works.where(category: @category.subtree.map{|c| c})
      @works = @works.paginate(:page => params[:page], :per_page => params[:per_page] || 12)
    elsif params[:f].present?
      @works = @works.paginate(:page => params[:page], :per_page => params[:per_page] || 12)
    else
      @work_categories = Category.friendly.find('works').children
    end
  end

  def work
    @work = Work.active.friendly.find(params[:work_id])
    @related_works = @work.category.works.active.where.not(id: @work.id).limit(10).shuffle
  end

  def work_tag
    @tag = Tag.friendly.find(params[:tag_id])
    @works = @works.where(id: Tagging.where(taggable_type: 'Work', tag_id: @tag.id ).map(&:taggable_id))
    @works = @works.paginate(:page => params[:page], :per_page => params[:per_page] || 12)
    render :works
  end

  def cart
  end

  def checkout
    redirect_to cart_page_url if @cart[:items].blank?
  end

  def confirm
  end

  def partners
  end

  def services
    @article = Article.friendly.find(params[:article_id])
  end

  def about
    @article = Article.about.order(position: :asc).first
  end

  def news
    @articles = Article.news.order(position: :asc).paginate(:page => params[:page], :per_page => 2)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def article
    @article = Article.friendly.find(params[:article_id])
  end

  def contact
    if user_signed_in?
      @contact = Contact.new(name: current_user.name, email: current_user.email)
    else
      @contact = Contact.new
    end
  end

  def soon
  end
end
