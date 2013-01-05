commentForm = document.querySelector '.js-new-comment-form'

selectElements = =>
  @actions        = commentForm.querySelector '.form-actions'
  @bubblesContent = document.querySelectorAll '.discussion-bubble.js-comment-container'
  @bubble         = @bubblesContent[@bubblesContent.length - 1]
  @close          = @actions.querySelector '.js-comment-and-button'
  @comment        = @actions.querySelector '.primary'
  @textarea       = commentForm.querySelector 'textarea'

if commentForm
  do selectElements

  MutationObserver = WebKitMutationObserver or MozMutationObserver

  observer = new MutationObserver (mutations) ->
    mutations.forEach (mutation) ->
      do selectElements

  observer.observe @actions, childList: true

  button = (text, innerHtml, closable = true) =>
    btn = document.createElement 'button'

    btn.innerHTML = text
    btn.className = 'classy'
    btn.setAttribute 'tabindex', '1'
    btn.setAttribute 'type', 'submit'
    btn.setAttribute 'title', innerHTML
    btn.setAttribute 'style', 'margin-right: 4px;'

    btn.addEventListener 'click', (event) =>
      do event.preventDefault
      @textarea.innerHTML = innerHtml

      if closable then do @close.click else do @comment.click

      @textarea.innerHTML = ''

    btn

  insertButtons = =>
    div = document.createElement 'div'
    div.setAttribute 'style', 'float: left; margin: -38px 0px 0px 60px;'

    # Sample application
    btn = button 'Sample app', 'Can you please provide a sample application that reproduces the error?', false
    div.appendChild btn

    # Wiki
    btn = button "Wiki", "The wiki is maintained by the community. So if there aren't any up to date instructions, we recommend you to explore the solution yourself and hopefully contribute your findings back!"
    div.appendChild btn

    # Mailing list
    btn = button "Mailing list", "Please use the mailing list or StackOverflow for questions"
    div.appendChild btn

    # Bug report
    btn = button "Bad bug report", "You need to give us more information on how to reproduce this issue, otherwise there is nothing we can do. Please read CONTRIBUTING.md file for more information about creating bug reports. Thanks!"
    div.appendChild btn

    # Shipit Squirrel
    btn = button "<img src='https://a248.e.akamai.net/assets.github.com/images/icons/emoji/shipit.png' width='14' height='14'>", ":shipit:", false
    div.appendChild btn

    # Hearts
    btn = button "<img src='https://a248.e.akamai.net/assets.github.com/images/icons/emoji/heart.png' width='14' height='14'>", ":heart: :green_heart: :blue_heart: :yellow_heart: :purple_heart:", false
    div.appendChild btn

    @bubble.appendChild div

  do insertButtons if commentForm && @close
