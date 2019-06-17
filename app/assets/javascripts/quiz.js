$(function(){
  var quiz = (function() {
    var $quizForm = $('#quiz-form');
    var $questionContainer = $quizForm.find('#question-container');
    var $title = $("<h3></h3>");
    var $option = $('input[type="radio"]').parent();
    var $nextBtn = $('button#right');
    var $prevBtn = $('button#left');
    var questions;
    var currentQuestionIdx = 0;
    var visitedQuestions = [];

    var start = function() {
      questions = getQuestions();
      $questionContainer.empty();

      displayQuestion();

      $nextBtn.on('click', function(e) {
        e.preventDefault();
        removeQuestion();
        currentQuestionIdx += 1;

        if(isEndOfQuiz()) return;

        displayQuestion();
        console.log(visitedQuestions);
      });

      $prevBtn.on('click', function(e) {
        e.preventDefault();
        if(isStartOfQuiz()) return;

        removeQuestion();
        currentQuestionIdx -= 1;
        displayQuestion();
        console.log(visitedQuestions);
      });

      /*
      $scoreContainer.hide();
      displayQuestion();

      $nextBtn.on('click', function(e) {
        e.preventDefault();

        removeQuestion();

        if(isEndOfQuiz()) {
          displayScore();
          return;
        }

        displayQuestion();
      });*/
    };

    var isStartOfQuiz = function() {
      return currentQuestionIdx === 0
    }
    var isEndOfQuiz = function() {
      return currentQuestionIdx >= questions.length;
    }

    var displayScore = function() {
      $scoreContainer.show();
    }

    var removeQuestion = function() {
      visitedQuestions[currentQuestionIdx] = $questionContainer.children().detach();
    }

    var createOption = function(option) {
      return $('#question-container').append("<div class='field'><div class='ui radio checkbox'><input type='radio' name='option'><label>" + option + "</label></div></div>") 
    }

    var displayQuestion = function() {

      if(visitedQuestions[currentQuestionIdx] !== undefined) {
        visitedQuestions[currentQuestionIdx].appendTo($questionContainer);
      }
      else {
        var question = questions[currentQuestionIdx];
        $title.clone().text(question.title).appendTo($questionContainer);
      }


      /*
      $quizContainer.find('form#quiz-form').append($questionContainer.clone());

      $.each(question.options, function(optionIdx, option){
        createOption(option);
      });

      $quizContainer.append($questionTitle.clone().text(question.title));
      */
    }

    var getQuestions = function() {
      return [
        {
          title: 'first question', 
          options: ['q1-opt1', 'opt2', 'opt3'],
          answer: 'opt2'
        },
        {
          title: 'second question', 
          options: ['q2-opt1', 'opt2', 'opt3'],
          answer: 'opt1'
        },
        {
          title: 'third question', 
          options: ['q3-opt1', 'opt2', 'opt3'],
          answer: 'opt3'
        }
      ];
    }

    return {
      start: start
    };
  })();

  quiz.start();

});

