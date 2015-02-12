( ($) ->

	def_options = 
		speed: 500
		auto: true
		direction_for_auto: "next" 

	user_options =

	$.fn.slider = (params) ->
		options = $.extend {}, def_options, user_options
		outer = ""
		btn_prev = ""
		btn_next = ""
		timer = ""
		inner = $(this)
		elems = inner.children()
		el_width = elems.eq(0).width()
		el_number = elems.length

		init = () ->

			bindEvents = () ->
				btn_prev.on "click", makeStepPrev
				btn_next.on "click", makeStepNext

				outer.hover ->
					btn_prev.stop(true).fadeIn()
					btn_next.stop(true).fadeIn()

					console.log "btns fadeIn"
				, ->
					btn_prev.stop(true).fadeOut()
					btn_next.stop(true).fadeOut()

					console.log "btns fadeOut"
					 

				console.log "Bind events"

			makeSliderWrap = () ->
				inner.wrap "<div class='slider__wrp'></div>"
				outer = inner.parent()

				console.log "Make slider wrap"

			makeNavigation = () ->
				outer.append "<div class='slider__btn_prev'></div><div class='slider__btn_next'></div>"
				btn_prev = $(".slider__btn_prev")
				btn_next = $(".slider__btn_next")

				console.log "Make navigation"

			makeSliderWrap()
			makeNavigation()
			bindEvents()

			timer = setInterval ->
			    btn_next.trigger "click", [true] if options.direction_for_auto == "next"
			    btn_prev.trigger "click", [true] if options.direction_for_auto == "prev"
			, 3000 if options.auto is true

		makeStepPrev = (event, auto) ->
			clearInterval(timer) if auto != true
			last_el = inner.children().last()

			makeFirst = () ->
				inner.prepend(last_el.css "marginLeft": -el_width)

			makeFirst()
			inner.children().eq(0).animate "margin": 0, options.speed

			console.log "make step prev"

		makeStepNext = (event, auto) ->
			clearInterval(timer) if auto != true
			first_el = inner.children().eq(0)

			makeLast = () ->
				inner.append first_el.css "margin": 0

			first_el.animate "marginLeft": -el_width, options.speed, makeLast

			console.log "make step next"

		init()

		@

) jQuery