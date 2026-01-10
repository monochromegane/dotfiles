package greet

import (
	"fmt"
	"io"
)

type Greeter struct {
	out io.Writer
}

func New(out io.Writer) *Greeter {
	return &Greeter{
		out: out,
	}
}

func (g *Greeter) Execute(name string) error {
	_, err := fmt.Fprintf(g.out, "Hello %s\n", name)
	return err
}
