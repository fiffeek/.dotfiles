#!/usr/bin/python3

from __future__ import annotations

from enum import Enum
import os
import re
import subprocess
from dataclasses import dataclass
from typing import Optional, Tuple
from datetime import datetime

UPOWER_BIN = "upower"
HISTORICAL_STATS_LOCATION = "/var/lib/upower/"
HISTORICAL_STATS_LOCATION_REGEX = r"history-rate-{}-.*\.dat$"
POWER_SUPPLY_ONLINE_FILE = "/sys/class/power_supply/ACAD/online"
TAIL_LINE_COUNT = 5000


class ChargingState(Enum):
    CHARGING = "charging"
    DISCHARGING = "discharging"
    UNKNOWN = "unknown"
    PENDING_CHARGE = "pending-charge"
    FULLY_CHARGED = "fully-charged"


@dataclass
class ChargingStatus:
    state: ChargingState
    updated_at: datetime

    @staticmethod
    def from_line(line: str) -> ChargingStatus:
        epoch, _, state = line.split("\t")
        return ChargingStatus(
            ChargingState(state), updated_at=datetime.fromtimestamp(int(epoch))
        )


def get_battery_device() -> str:
    upower_enum = subprocess.run([UPOWER_BIN, "-e"], stdout=subprocess.PIPE)
    devices = upower_enum.stdout.decode().splitlines()
    battery_device = [device for device in devices if "BAT" in device]
    assert len(battery_device) == 1, "No battery device detected"

    return battery_device[0]


def get_model(battery_device: str) -> str:
    upower_info = subprocess.run(
        [UPOWER_BIN, "-i", battery_device], stdout=subprocess.PIPE
    )
    out = upower_info.stdout.decode().splitlines()
    model_line = [line for line in out if "model" in line]
    assert len(model_line) == 1, "No model line in upower output"

    model = model_line[0].split()[-1]
    assert len(model) > 0, f"No model in the model line {model_line[0]}"

    return model


def get_stats(model: str) -> Optional[ChargingStatus]:
    regex = re.compile(HISTORICAL_STATS_LOCATION_REGEX.format(model))
    stats_file = None

    for _, _, files in os.walk(HISTORICAL_STATS_LOCATION):
        for file in files:
            if not regex.match(file):
                continue
            if stats_file is not None:
                raise RuntimeError(
                    "More than one file matches the historical charge rate regex"
                )
            stats_file = file

    assert stats_file is not None, "No stats file"

    contents = subprocess.run(
        [
            "tail",
            "-n",
            f"{TAIL_LINE_COUNT}",
            f"{HISTORICAL_STATS_LOCATION}/{stats_file}",
        ],
        stdout=subprocess.PIPE,
    )
    reversed_lines = list(reversed(contents.stdout.decode().splitlines()))
    statuses = [ChargingStatus.from_line(line) for line in reversed_lines]

    charging_statuses = [
        status for status in statuses if status.state == ChargingState.CHARGING
    ]
    last_known_charging_status = (
        charging_statuses[0] if len(charging_statuses) > 0 else None
    )
    return last_known_charging_status


def print_time_on_battery(
    last_known_charging_status: Optional[ChargingStatus],
    using_battery: bool,
) -> None:
    if last_known_charging_status is None or not using_battery:
        return
    delta = datetime.now() - last_known_charging_status.updated_at
    hours, minutes, _ = str(delta).split(":")
    print(f"󱟟 {hours}:{minutes}")


def check_if_using_battery() -> bool:
    with open(POWER_SUPPLY_ONLINE_FILE, "r") as f:
        flag = f.readline().strip("\n")
        return flag == "0"


def main():
    battery_device = get_battery_device()
    model = get_model(battery_device)
    last_known_charging_status = get_stats(model)
    using_battery = check_if_using_battery()
    print_time_on_battery(last_known_charging_status, using_battery)


if __name__ == "__main__":
    main()
