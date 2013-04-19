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

  mutationObserver =
    if WebKitMutationObserver?
      WebKitMutationObserver
    else
      MutationObserver

  observer = new mutationObserver (mutations) ->
    mutations.forEach (mutation) ->
      do selectElements

  observer.observe @actions, childList: true

  button = (text, innerHtml, closable = true) =>
    btn = document.createElement 'button'

    btn.innerHTML = text
    btn.className = 'button'
    btn.setAttribute 'tabindex', '1'
    btn.setAttribute 'type', 'submit'
    btn.setAttribute 'title', innerHtml

    btn.addEventListener 'click', (event) =>
      do event.preventDefault
      @textarea.value += " #{innerHtml}"

      if closable then do @close.click else do @comment.click

      @textarea.value = ''

    btn

  insertButtons = =>
    closeButtonGroupTitle           = document.createElement 'span'
    closeButtonGroupTitle.setAttribute 'style', 'float: left; margin: 0px 0px 0px 61px;'
    closeButtonGroupTitle.textContent = 'Close this issue'

    closeButtonGroup            = document.createElement 'div'
    closeButtonGroup.className  = 'button-group'
    closeButtonGroup.setAttribute 'style', 'float: left; margin: -40px 0px 0px 60px;'

    openButtonGroupTitle              = document.createElement 'span'
    openButtonGroupTitle.setAttribute 'style', 'float: left; margin: 0px 0px 0px 156px;'
    openButtonGroupTitle.textContent  = 'Keep it open'

    openButtonGroup             = document.createElement 'div'
    openButtonGroup.className   = 'button-group'
    openButtonGroup.setAttribute  'style', 'float: left; margin: -40px 0px 0px 155px;'

    # Sample application
    btn = button 'Sample app', 'Can you please provide a sample application that reproduces the error?', false
    openButtonGroup.appendChild btn

    # Wiki
    btn = button "Wiki", "The wiki is maintained by the community. So if there aren't any up to date instructions, we recommend you to explore the solution yourself and hopefully contribute your findings back!"
    closeButtonGroup.appendChild btn

    # Mailing list
    btn = button "ML", "Please use the mailing list or StackOverflow for questions/help, where a wider community will be able to help you. We reserve the issues tracker for issues only."
    closeButtonGroup.appendChild btn

    # Bug report
    btn = button "Bad bug report", "You need to give us more information on how to reproduce this issue, otherwise there is nothing we can do. Please read CONTRIBUTING.md file for more information about creating bug reports. Thanks!"
    closeButtonGroup.appendChild btn

    # Shipit Squirrel
    btn = button "<img src='https://a248.e.akamai.net/assets.github.com/images/icons/emoji/shipit.png' width='14' height='14'>", ":shipit:", false
    openButtonGroup.appendChild btn

    # Hearts
    btn = button "<img src='https://a248.e.akamai.net/assets.github.com/images/icons/emoji/heart.png' width='14' height='14'>", ":heart: :green_heart: :blue_heart: :yellow_heart: :purple_heart:", false
    openButtonGroup.appendChild btn

    @bubble.appendChild closeButtonGroup
    @bubble.appendChild closeButtonGroupTitle

    @bubble.appendChild openButtonGroup
    @bubble.appendChild openButtonGroupTitle

  do insertButtons if commentForm && @close
