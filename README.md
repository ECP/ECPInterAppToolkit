ECPInterAppToolkit
==================

[PhotoToaster](http://itunes.apple.com/app/phototoaster/id433671262?mt=8&uo=4&at=11l4JW&ct=interapp) registers the phototoaster-x-callback:// URL scheme and supports for integration with other apps via the [x-callback-url](http://x-callback-url.com/) protocol. The format for a URL action looks like this:

```
phototoaster-x-callback://x-callback-url/[action]?[action parameters]&[x-callback parameters]
```
Supported x-callback parameters: *x-source*, *x-success*, *x-error* and *x-cancel*.

##Actions
###/returnEditedClipboardImage

Open the image on the clipboard for editing and return the edited results via the clipboard. Not setting a source makes this a not so interesting call.

####Parameters

*preset* **(optional)** A preset that was previously returned by PhotoToaster. This is the initial set of settings to apply to the image. Since PhotoToaster isn't destructive users can always change any of the settings in PhotoToaster.

####Usage Examples
```
phototoaster-x-callback://x-callback-url/returnEditedClipboardImage?&x-source=YourAppScheme&x-success=YourAppCallback
```
This support allows other apps to launch PhotoToaster with an image and receive the edited results along with the preset used for the edits. You can see the integration in action in [PhotoMotion](http://itunes.apple.com/app/photomotion/id806306845?mt=8&uo=4&at=11l4JW&ct=interapp). Just check out the 'Edit In PhotoToaster' menu item. It allows you to edit images that are all ready placed in a PhotoMotion project.

The integration is based on the [x-callback-url](http://x-callback-url.com) spec. To keep the implementation of additional clients simple, we offer up an IACClient implementation to allow you to integrate in minutes. IACClient is part of [InterAppCommunication](https://github.com/tapsandswipes/InterAppCommunication). This library makes using x-callback painless. The documentation for integrating InterAppCommunication is great, and once you do, the only code you need from this repo is ECP_EditAndReturnIACClient. You can use PhotoTotaster's edit and return capability without using any of this code, you jus have to send a proper x-callback request (and have an image on the clipboard). 