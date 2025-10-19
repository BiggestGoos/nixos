{ osConfig, config, szy, lib, desktop, pkgs, ... }:
let

	devices = osConfig."${szy}".desktops.options.devices;

	keyboardConfig = keyboard: 
	{

		kb_model = lib.mkIf (keyboard.xkb.model != null) keyboard.xkb.model;
		kb_layout = lib.mkIf (keyboard.xkb.layout != null) keyboard.xkb.layout;
		kb_variant = lib.mkIf (keyboard.xkb.variant != null) keyboard.xkb.variant;
		kb_options = lib.mkIf (keyboard.xkb.options != null) keyboard.xkb.options;
		kb_rules = lib.mkIf (keyboard.xkb.rules != null) keyboard.xkb.rules;

		repeat_rate = lib.mkIf (keyboard.repeat.rate != null) keyboard.repeat.rate;
		repeat_delay = lib.mkIf (keyboard.repeat.delay != null) keyboard.repeat.delay;

	};

	genericPointerConfig = genericPointer:
	{

		sensitivity = lib.mkIf (genericPointer.sensitivity != null) genericPointer.sensitivity;

		accel_profile = 
		let
			profile = if (builtins.isString genericPointer.acceleration) then genericPointer.acceleration else 
				"custom ${builtins.toString genericPointer.acceleration.movement.step} ${lib.strings.concatStringsSep " " (builtins.map (point: builtins.toString point) genericPointer.acceleration.movement.points)}";
		in
			lib.mkIf (genericPointer.acceleration != null && genericPointer.acceleration != "none") profile;

		force_no_accel = lib.mkIf (genericPointer.acceleration != null && genericPointer.acceleration == "none") true;

		scroll_points = 
		let
			scrollPoints = "${builtins.toString genericPointer.acceleration.scrolling.step} ${lib.strings.concatStringsSep " " (builtins.map (point: builtins.toString point) genericPointer.acceleration.scrolling.points)}";
		in
			lib.mkIf ((genericPointer.acceleration != null) && ((builtins.isString genericPointer.acceleration) == false) && (genericPointer.acceleration.scrolling != null)) scrollPoints;
	
		scroll_method = 
		let
			method = genericPointer.scrolling.method;
			methodMap = {
				twoFingers = "2fg";
				edge = "edge";
				none = "no_scroll";
			};
			resolvedMethod = if (builtins.isString method) then methodMap."${method}" else "on_button_down";
		in
			lib.mkIf (method != null) resolvedMethod;

		scroll_button = 
		let
			method = genericPointer.scrolling.method;
			buttonID = method.scrollButton.id;
		in
			lib.mkIf (method != null && (method ? scrollButton) && buttonID != null) buttonID;

		scroll_button_lock = 
		let
			method = genericPointer.scrolling.method;
			lock = method.scrollButton.lock;
		in
			lib.mkIf (method != null && (method ? scrollButton) && lock != null) lock;

		scroll_factor = lib.mkIf (genericPointer.scrolling.factor != null) genericPointer.scrolling.factor;
		natural_scroll = lib.mkIf (genericPointer.scrolling.natural != null) genericPointer.scrolling.natural;

	};

	mouseConfig = mouse:
	{

		# Not yet in latest release of Hyprland
		#rotation = lib.mkIf (mouse.rotation != null) mouse.rotation;

	};

	touchpadConfig = touchpad:
	{

		#touchpad = {
			disable_while_typing = lib.mkIf (touchpad.disableWhileTyping != null) touchpad.disableWhileTyping;
			scroll_factor = lib.mkIf (touchpad.scrolling.factor != null) touchpad.scrolling.factor;
			natural_scroll = lib.mkIf (touchpad.scrolling.natural != null) touchpad.scrolling.natural;
			middle_button_emulation = lib.mkIf (touchpad.middleButtonEmulation != null) touchpad.middleButtonEmulation;
			clickfinger_behavior = lib.mkIf (touchpad.clickfingerBehavior != null) touchpad.clickfingerBehavior;
			tap-to-click = lib.mkIf (touchpad.tapToClick != null) touchpad.tapToClick;
			tap-and-drag = lib.mkIf (touchpad.tapAndDrag != null) (if (builtins.isBool touchpad.tapAndDrag) then touchpad.tapAndDrag else true);
			drag_lock = lib.mkIf (touchpad.tapAndDrag != null && (builtins.isString touchpad.tapAndDrag)) ({ noLock = 0; timeout = 1; sticky = 2; })."${touchpad.tapAndDrag}";
			flip_x = lib.mkIf (touchpad.flipMovement.x != null) touchpad.flipMovement.x;
			flip_y = lib.mkIf (touchpad.flipMovement.y != null) touchpad.flipMovement.y;
		#};

	};

in
{

	wayland.windowManager.hyprland.settings = {

		# TODO: Make at least layout look at the locale and try to find most fitting keyboard layout to use as default
		input =
		let

			keyboard = devices.keyboards.default;
			mouse = devices.pointers.mice.default;
			touchpad = devices.pointers.touchpads.default;
			genericPointer = devices.pointers.generics.default;

		in
		szy.utils.mergeAll [ (keyboardConfig keyboard) (genericPointerConfig genericPointer) (mouseConfig mouse) ({ touchpad = (touchpadConfig touchpad); }) ];

		device = 
		let
			keyboards = devices.keyboards.keyboards;
			mice = devices.pointers.mice.mice;
			touchpads = devices.pointers.touchpads.touchpads;
			genericPointers = devices.pointers.generics.generics;
		in
		(lib.attrsets.mapAttrsToList (name: keyboard: szy.utils.mergeAll [ (keyboardConfig keyboard) { name = keyboard.hardware.name; } ]) keyboards) ++
		(lib.attrsets.mapAttrsToList (name: mouse: szy.utils.mergeAll [ (genericPointerConfig mouse) (mouseConfig mouse) { name = mouse.hardware.name; } ]) mice) ++
		(lib.attrsets.mapAttrsToList (name: touchpad: szy.utils.mergeAll [ (genericPointerConfig touchpad) (touchpadConfig touchpad) { name = touchpad.hardware.name; } ]) touchpads) ++
		(lib.attrsets.mapAttrsToList (name: genericPointer: szy.utils.mergeAll [ (genericPointerConfig genericPointer) { name = genericPointer.hardware.name; } ]) genericPointers);

	};

}
