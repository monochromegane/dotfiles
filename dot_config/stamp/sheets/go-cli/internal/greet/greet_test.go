package greet

import (
	"bytes"
	"testing"
)

func TestExecute(t *testing.T) {
	tests := []struct {
		name     string
		arg      string
		expected string
	}{
		{
			name:     "default greeting",
			arg:      "world",
			expected: "Hello world\n",
		},
		{
			name:     "custom greeting",
			arg:      "Alice",
			expected: "Hello Alice\n",
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			var buf bytes.Buffer
			greeter := New(&buf)

			err := greeter.Execute(tt.arg)

			if err != nil {
				t.Errorf("Execute() returned error: %v", err)
			}

			output := buf.String()
			if output != tt.expected {
				t.Errorf("Execute() output = %q, want %q", output, tt.expected)
			}
		})
	}
}
