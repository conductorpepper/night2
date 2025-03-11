# Modules

Some of these modules are _bundles_, a module that enables and configures other modules and options. `bundles.jellyfin`, for example, enables Jellyfin, opens the firewall, and adds more packages; additionally, `bundles.tailscale` sets up Tailscale.

Like bundles, some of these modules are _utils_, a module that really does not do anything on its own but allows other modules to take those settings into account.
For instance, the [hypridle](/home/desktop/hypretc.nix) options use `utils.exssd` to not suspend the computer since it turns the computer off otherwise.

The intent is to _modularize_ the configuration and be more specific depending on the host. For comparison, I had a server directory where it adds both Jellyfin and Tailscale, and I don't think that scales great in the long run.
