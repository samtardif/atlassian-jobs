class SiteView.Github extends SiteView.SiteContentView
  tagName:   'section'
  className: 'github'

  template: _.template("""
    <img src="<%= Gravtastic(user.email) %>" />
    <span class="username"><%= user.username %></span>
    <span class="following">Following <%= user.following_count %> people.</span>
    <span class="following"><%= user.followers_count %> followers.</span>
  """)
