# Modules

Some of these modules are _bundles_, a module that enables and configures other modules and options. `bundles.jellyfin`, for example, enables Jellyfin, opens the firewall, and adds more packages; additionally, `bundles.tailscale` sets up Tailscale.

The intent is to _modularize_ the configuration and be more specific depending on the host. For comparison, I had a server directory where it adds both Jellyfin and Tailscale, and I don't think that scales great in the long run.
