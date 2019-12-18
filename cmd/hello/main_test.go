package main

import (
	"io/ioutil"
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/stretchr/testify/require"
)

func Test_Hello(t *testing.T) {
	name := "asdfasdf"
	req := httptest.NewRequest("GET", "http://localhost:8080/"+name, nil)
	w := httptest.NewRecorder()

	Hello(w, req)

	//nolint:bodyclose
	resp := w.Result()
	require.Equal(t, resp.StatusCode, http.StatusOK)
	body, err := ioutil.ReadAll(resp.Body)
	defer func() {
		err := resp.Body.Close()
		require.NoError(t, err, "response body must successfully close")
	}()
	require.NoError(t, err, "Hello request should not error")
	require.Equal(t, "Hello, "+name, string(body))
}
