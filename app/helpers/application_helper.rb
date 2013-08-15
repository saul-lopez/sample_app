module ApplicationHelper
  # returns the full title on a per page basis
  def full_title(page_title)
    base_title = 'Ruby on Rails Tutorial Sample App'
    # Ojo empty regresa false para cadenas con solo espacios
    # por eso se usa blank?:
    # http://stackoverflow.com/questions/885414/a-concise-explanation-of-nil-v-empty-v-blank-in-ruby-on-rails
    if page_title.blank?
      return base_title
    end
    "#{base_title} | #{page_title}"
  end
end
