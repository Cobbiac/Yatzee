(ns reagent-starter-project.app.core-test)


(ns reagent-starter-project.app.core-test
  (:require [cljs.test :as t :refer [deftest test-all-vars]]
            [reagent-starter-project.app.core])) ; ensure ns is loaded

; Ensures that any vars in reagent-starter-project.app.core
; with ^:test metadata are executed when running this test ns.
(deftest run-inline-meta-tests
  (test-all-vars 'reagent-starter-project.app.core))
