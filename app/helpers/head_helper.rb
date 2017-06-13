module HeadHelper
	def head_allow_robots?
		controller_name.to_sym == :pages
	end

	def head_title
		title = ''
		case controller_name.to_sym
		when :pages
			case action_name.to_sym
			when :home
				title = 'Home | '
			when :products, :tag
				title = (@category.title rescue 'Productos') + ' | '
			when :product
				title = @product.title + ' | '
			when :works, :work_tag
				title = (@category.title rescue 'Obras') + ' | '
			when :work
				title = @work.title + ' | '
			when :cart
				title = 'Carrito | '
			when :checkout
				title = 'Checkout | '
			when :partners
				title = 'Club de Partners | '
			when :services, :article
				title = @article.title + ' | '
			when :about
				title = 'La Empresa | '
			when :news
				title = 'Noticias | '
			when :contact
				title = 'Contacto | '
			end
		end
		title + 'Aria'
	end

	def head_description
		case controller_name.to_sym
		when :pages
			case action_name.to_sym
			when :product
				return sanitize @product.characteristics, tags: []
			end
		end
		'Somos una compañía especializada en climatización, con un gran expertise en asesoramiento técnico, comercialización, instalación y mantenimiento de equipos de aire acondicionado.'
	end

	def head_og_image
		case controller_name.to_sym
		when :pages
			case action_name.to_sym
			when :product
				return asset_url(@product.image :small)
			end
		end
		asset_url 'aria-logo.png'
	end

	def head_og_image_type
		case controller_name.to_sym
		when :pages
			case action_name.to_sym
			when :product
				return @product.images.first.item.content_type
			end
		end
		'image/png'
	end

	def head_og_image_width
		case controller_name.to_sym
		when :pages
			case action_name.to_sym
			when :product
				return '500'
			end
		end
		'192'
	end

	def head_og_image_height
		case controller_name.to_sym
		when :pages
			case action_name.to_sym
			when :product
				return '460'
			end
		end
		'192'
	end
end
