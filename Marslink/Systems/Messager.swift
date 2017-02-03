/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation

protocol MessagerDelegate: class {
    func messagerDidUpdateMessages(messager: Messager)
}

private func delay(time: Double = 1, execute work: @escaping @convention(block) () -> Swift.Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
        work()
    }
}

private func lewisMessage(text: String, interval: TimeInterval) -> Message {
    let user = "cpt.lewis"
    //let interval_ = Date().timeIntervalSinceReferenceDate
    return Message(date: Date(timeIntervalSinceNow: interval), text: text, name: user)
}

class Messager {
    
    weak var delegate: MessagerDelegate?
    
    var messages: [Message] = {
        var arr = [Message]()
        arr.append(lewisMessage(text: "Mark, are you receiving me?", interval: -1))
        arr.append(lewisMessage(text: "I think I left behind some ABBA, might help with the drive 😜", interval: -2))
        return arr
        }() {
        didSet {
            delegate?.messagerDidUpdateMessages(messager: self)
        }
    }
    
    func connect() {
        delay(time: 2.3) {
            self.messages.append(lewisMessage(text: "LiftoI think I left behind some ABBA, might help with the drive I think I left behind some ABBA, might help with the drive I think I left behind some ABBA, might help with the drive I think I left behind some ABBA, might help with the drive I think I left b...", interval: -4.2))
        }
    }
}
