package types

import "time"

type Config struct {
	ShutdownTimeout time.Duration

	DBConnectionURL string
}
