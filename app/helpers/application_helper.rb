module ApplicationHelper
    # Usage: <%= icon("bicycle", class: "text-success") %>
    # Example with HTML markup: <li><%= link_to logout_path, class: "nav-link" do%> <%= icon("house", class: "house-nav-link") %> <% end %></li>
    def icon(icon, options = {})
        file = File.read("#{Rails.root}/node_modules/bootstrap-icons/icons/#{icon}.svg")
        doc = Nokogiri::HTML::DocumentFragment.parse file
        svg = doc.at_css 'svg'
        if options[:class].present?
          svg['class'] += " " + options[:class]
        end
          doc.to_html.html_safe
    
    end
end
