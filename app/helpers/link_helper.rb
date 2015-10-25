module LinkHelper
  def link_item(text, url, css_class = nil)
    link_to(text, url, css_class) if link_item_visible?(url)
  end

  private

  def link_item_visible?(url)
    parsed_params = Rails.application.routes.recognize_path(url)
    policy_class = parsed_params[:controller].classify.constantize
    policy_method = "#{parsed_params[:action]}?"

    policy(policy_class).send(policy_method)
  end
end