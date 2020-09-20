#!/bin/bash
spd-say-rand() {
    voice=(male1 male2 male3 female1 female2 female3 child_male child_female)
    pm() { shuf -n1 -e '-' '+'; }
    rn() { echo $((RANDOM % 101)); }
    vo_t() { shuf -n1 -e "${voice[@]}"; }
    spd-say -r "$(pm)$(rn)" -p "$(pm)$(rn)" -i "$(pm)$(rn)" -t "$(vo_t)" "$1"
}

spd-say-rand "$@"
exit $?
