class SiteView.BitBucket extends SiteView.SiteContentView
  tagName:   'section'
  className: 'bitbucket'

  template: _.template("""
    <img src="<%= user.avatar %>" />
    <span class="username"><%= user.username %></span>
    <span class="repos"><%= repositories.length %> repos.</span>
  """)

  report: _.template("""
    <%= user.username %> has <%= repositories.length %> repos on Bitbucket.
  """)
