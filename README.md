`WARNING`

This cookbook is useless because incron is not work well.

Use [rbenv-install-rubies-cookbook](https://github.com/akahigeg/rbenv-install-rubies-cookbook) instead of this.

## Description

Resolve a gem permission issue for system wide rbenv installed by [rbenv cookbook](https://github.com/RiotGames/rbenv-cookbook).

Change owner of rbenv versions directory(default:/opt/rbenv/versions) to rbenv user(default:rbenv) forcibly.

## Depends

* [rbenv](https://github.com/RiotGames/rbenv-cookbook)
* [incron](https://github.com/dwradcliffe/chef-incron)

## How to use

1. Run chef to install rbenv by rbenv cookbook.
2. Install rubies by rbenv.
3. Run chef again (Enable incron for installed rubies).
4. Feel free to type 'gem install' and 'bundle install' on your server!

## Sample JSON

    {
      "run_list": [
        "recipe[rbenv::default]"
        "recipe[rbenv::ruby_build]"
        "recipe[rbenv-force-owner]"
      ],
      "rbenv": {
        "group_users": ["taro", "jiro" "saburo"]
      }
    }
