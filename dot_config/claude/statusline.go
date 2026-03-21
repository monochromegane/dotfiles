package main

import (
	"encoding/json"
	"fmt"
	"math"
	"os"
	"strings"
)

var braille = []rune{' ', '⣀', '⣄', '⣤', '⣦', '⣶', '⣷', '⣿'}

const (
	reset = "\033[0m"
	dim   = "\033[2m"
)

type input struct {
	Model struct {
		DisplayName string `json:"display_name"`
	} `json:"model"`
	ContextWindow struct {
		UsedPercentage float64 `json:"used_percentage"`
	} `json:"context_window"`
	RateLimits struct {
		FiveHour struct {
			UsedPercentage *float64 `json:"used_percentage"`
		} `json:"five_hour"`
		SevenDay struct {
			UsedPercentage *float64 `json:"used_percentage"`
		} `json:"seven_day"`
	} `json:"rate_limits"`
}

func gradient(pct float64) string {
	if pct < 50 {
		r := int(pct * 5.1)
		return fmt.Sprintf("\033[38;2;%d;200;80m", r)
	}
	g := max(int(200-(pct-50)*4), 0)
	return fmt.Sprintf("\033[38;2;255;%d;60m", g)
}

func brailleBar(pct float64, width int) string {
	pct = math.Max(0, math.Min(100, pct))
	level := pct / 100
	var b strings.Builder
	for i := range width {
		segStart := float64(i) / float64(width)
		segEnd := float64(i+1) / float64(width)
		if level >= segEnd {
			b.WriteRune(braille[7])
		} else if level <= segStart {
			b.WriteRune(braille[0])
		} else {
			frac := (level - segStart) / (segEnd - segStart)
			idx := min(int(frac*7), 7)
			b.WriteRune(braille[idx])
		}
	}
	return b.String()
}

func fmtMetric(label string, pct float64) string {
	p := int(math.Round(pct))
	return fmt.Sprintf("%s%s%s %s%s%s %d%%", dim, label, reset, gradient(pct), brailleBar(pct, 8), reset, p)
}

func main() {
	var d input
	if err := json.NewDecoder(os.Stdin).Decode(&d); err != nil {
		return
	}

	sep := fmt.Sprintf(" %s│%s ", dim, reset)
	var parts []string

	if name := d.Model.DisplayName; name != "" {
		parts = append(parts, name)
	}

	parts = append(parts, fmtMetric("ctx", d.ContextWindow.UsedPercentage))

	if d.RateLimits.FiveHour.UsedPercentage != nil {
		parts = append(parts, fmtMetric("5h", *d.RateLimits.FiveHour.UsedPercentage))
	}
	if d.RateLimits.SevenDay.UsedPercentage != nil {
		parts = append(parts, fmtMetric("7d", *d.RateLimits.SevenDay.UsedPercentage))
	}

	fmt.Print(strings.Join(parts, sep))
}
