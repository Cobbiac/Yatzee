(ns yatzee.app.core-test)


(ns yatzee.app.core-test
  (:require [cljs.test :as t :refer [deftest test-all-vars]]
            [yatzee.app.core])) ; ensure ns is loaded

; Ensures that any vars in yatzee.app.core
; with ^:test metadata are executed when running this test ns.
(deftest run-inline-meta-tests
  (test-all-vars 'yatzee.app.core))
