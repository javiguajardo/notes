module ApplicationHelper
  def bootstrap_flash_class(flash_type)
    {success: 'alert-success',
     error: 'alert-danger',
     alert: 'alert-warning',
     notice: 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def custom_paginator(resource)
    will_paginate resource, renderer: BootstrapPagination::Rails, class: 'pagination',
                  next_label: '<i class="fa fa-chevron-right"></i>'.html_safe,
                  previous_label: '<i class="fa fa-chevron-left"></i>'.html_safe
  end

  def page_title
    @title || controller_name.gsub(/Controller/, "").humanize
  end
end
