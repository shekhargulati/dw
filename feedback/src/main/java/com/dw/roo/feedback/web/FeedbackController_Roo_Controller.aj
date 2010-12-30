// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.dw.roo.feedback.web;

import com.dw.roo.feedback.domain.Feedback;
import java.io.UnsupportedEncodingException;
import java.lang.Integer;
import java.lang.String;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect FeedbackController_Roo_Controller {
    
    @Autowired
    private GenericConversionService FeedbackController.conversionService;
    
    @RequestMapping(method = RequestMethod.POST)
    public String FeedbackController.create(@Valid Feedback feedback, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("feedback", feedback);
            return "feedbacks/create";
        }
        feedback.persist();
        return "redirect:/feedbacks/" + encodeUrlPathSegment(feedback.getId().toString(), request);
    }
    
    @RequestMapping(params = "form", method = RequestMethod.GET)
    public String FeedbackController.createForm(Model model) {
        model.addAttribute("feedback", new Feedback());
        return "feedbacks/create";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String FeedbackController.show(@PathVariable("id") Integer id, Model model) {
        model.addAttribute("feedback", Feedback.findFeedback(id));
        model.addAttribute("itemId", id);
        return "feedbacks/show";
    }
    
    @RequestMapping(method = RequestMethod.GET)
    public String FeedbackController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            model.addAttribute("feedbacks", Feedback.findFeedbackEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) Feedback.countFeedbacks() / sizeNo;
            model.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            model.addAttribute("feedbacks", Feedback.findAllFeedbacks());
        }
        return "feedbacks/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String FeedbackController.update(@Valid Feedback feedback, BindingResult result, Model model, HttpServletRequest request) {
        if (result.hasErrors()) {
            model.addAttribute("feedback", feedback);
            return "feedbacks/update";
        }
        feedback.merge();
        return "redirect:/feedbacks/" + encodeUrlPathSegment(feedback.getId().toString(), request);
    }
    
    @RequestMapping(value = "/{id}", params = "form", method = RequestMethod.GET)
    public String FeedbackController.updateForm(@PathVariable("id") Integer id, Model model) {
        model.addAttribute("feedback", Feedback.findFeedback(id));
        return "feedbacks/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    public String FeedbackController.delete(@PathVariable("id") Integer id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model model) {
        Feedback.findFeedback(id).remove();
        model.addAttribute("page", (page == null) ? "1" : page.toString());
        model.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/feedbacks?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
    Converter<Feedback, String> FeedbackController.getFeedbackConverter() {
        return new Converter<Feedback, String>() {
            public String convert(Feedback feedback) {
                return new StringBuilder().append(feedback.getAttendeeemail()).append(" ").append(feedback.getTalktitle()).append(" ").append(feedback.getFeedback()).toString();
            }
        };
    }
    
    @PostConstruct
    void FeedbackController.registerConverters() {
        conversionService.addConverter(getFeedbackConverter());
    }
    
    private String FeedbackController.encodeUrlPathSegment(String pathSegment, HttpServletRequest request) {
        String enc = request.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        }
        catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}