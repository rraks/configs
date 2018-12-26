# Project and root directories
PROJ_DIR=~/Work/gitrepos/uwb/src_python
FILE_NAME=singleAnchorKalman.py
ROOT_DIR=$PWD

# Aux directories
ROSBAG=/home/thepro/Work/bebop_ws/uwbOpt/exp1/

SETUP_BASH=~/Work/bebop_ws/devel/setup.bash


# $ Arguments required to allow resizing
tmux new-session -s "UWB"  -d -x "$(tput cols)" -y "$(tput lines)"


tmux new-window -t "UWB":0 -n "NEOVIM"

tmux split-window -t "UWB":0.0 -h 
tmux resize-pane -t "UWB":0.0 -R 40

tmux split-window -t "UWB":0.1 -v
tmux resize-pane -t "UWB":0.1 -y 60 

tmux split-window -t "UWB":0.2 -v
tmux resize-pane -t "UWB":0.2 -y 5 



#tmux send-keys -t "UWB":0.0 "cd ${PROJ_DIR} && nvim ${FILE_NAME} -c 'redr'" C-j

tmux send-keys -t "UWB":0.1 "cd ${PROJ_DIR}" C-j

tmux send-keys -t "UWB":0.2 "cd ${ROSBAG}" C-j

tmux send-keys -t "UWB":0.3 "roscore" C-j





tmux a -t "UWB"





