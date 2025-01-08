set -l joined (string join " " $fish_complete_path)
set -l prev_joined (string replace --regex "[^\s]*generated_completions.*" "" $joined)
set -l post_joined (string replace $prev_joined "" $joined)
set -l prev (string split " " (string trim $prev_joined))
set -l post (string split " " (string trim $post_joined))
set fish_complete_path $prev "/home/asrifox/.local/share/fish/home-manager_generated_completions" $post
